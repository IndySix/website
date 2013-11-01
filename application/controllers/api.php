<?php if (!defined('__SITE_PATH')) exit('No direct script access allowed');

class api extends controller {
	function index(){
      $this->load->view('api');	
   }

   function checkinUser(){
      header('Access-Control-Allow-Origin: *');
      $this->load->model('users');
      $this->load->library('JSend');
      $rfid = $this->uri->segment(3);

      $result = $this->users->getUserByRfid($rfid);
      if($result != null){
         $user = new stdClass();
         $user->username = $result['username'];
         $user->avatarUrl = baseUrl("data/avatars/".$result['avatar']);

         //get level/challenge object
         $this->load->model('levels');
         $level = $this->levels->getLevelById($result['current_level_id']);
         
         if($level != null){
            $levelScore = $this->levels->getTopScoreUserLevel($result['id']);
            $user->levelScore = empty($levelScore) ? 0 : $levelScore['score'];
            $user->attempt = $this->levels->getLevelAttemptUser($result['id'], $level['id']);
            
            $user->level = new stdClass();
            //set level info
            $user->level->levelNumb = $level['order'];
            $user->level->title = $level['title'];
            $user->level->description = $level['description'];
            $user->level->playTime =  (int)$level['play_time'];
            $user->level->one_star_score = $level['one_star_score'];
            $user->level->two_star_score = $level['two_star_score'];
            $user->level->three_star_score = $level['three_star_score'];
            $user->level->four_star_score = $level['four_star_score'];
            $user->level->mp4_url = baseUrl("data/videos/".$level['example_movie'].".mp4");
            $user->level->ogg_url = baseUrl("data/videos/".$level['example_movie'].".ogg");

            // foreach ($level as $key => $value) {
            //    if(!is_numeric($key))
            //       $user->level->$key = $value;
            // }

            //get top 10 scores
            $topScores = array();
            $scores = $this->levels->getCompletedLevelsByLevelId($level['id']);
            foreach ($scores as $score) {
               $scoreClass = new stdClass();
               $scoreClass->username = $score['username'];
               $scoreClass->score    = $score['score'];
      
               $topScores[] = $scoreClass;
            }

            $user->level->topScores = $topScores;

            $this->JSend->data = $user;
         } else {
            $this->JSend->setStatus(JSend::$FAIL);
            $this->JSend->data = "There is no level selected for current user!";
         }
         
      } else {
         $this->JSend->setStatus(JSend::$FAIL);
         $this->JSend->data = "There is no user with this rfid!";
      }
      echo $this->JSend->getJson();
   }

   function latestResultsParts(){
      header('Access-Control-Allow-Origin: *');
      $this->load->model('levels');
      $this->load->library('JSend');
      $partName = $this->uri->segment(3);

      $result = $this->levels->getLatestCompletedLevelsByPartName($partName);
      if($result != null){
         $array = array();
         foreach ($result as $items) {
            $item = new stdClass();
            foreach ($items as $key => $value) {
               if (!is_numeric($key)) 
                  $item->$key = $value;
            }
            $array[] = $item;
         }

         $this->JSend->data = $array;
      } else {
         $this->JSend->setStatus(JSend::$FAIL);
         $this->JSend->data = "The part is not found!";
      }
      echo $this->JSend->getJson();
   }

   function getKingPart(){
      header('Access-Control-Allow-Origin: *');
      $this->load->model('levels');
      $this->load->library('JSend');
      $partName = $this->uri->segment(3);

      $this->db->reset();
      $this->db->where("name",$partName);
      $result = $this->db->get("Parts");

      if(!empty($result)){
         $result = $this->levels->getTopUserPartById($result[0]['id']);
         
         if($result != null){
            $user = new stdClass();
            $user->username = $result['username'];
            $user->avatarUrl = baseUrl("data/avatars/".$result['avatar']);
            $user->score   = $result['score'];
            $this->JSend->data = $user;
            echo $this->JSend->getJson();
            return;
         }
      } 
      $this->JSend->setStatus(JSend::$FAIL);
      $this->JSend->data = "The part is not found!";
      echo $this->JSend->getJson();
   }

   function uploadChallengeResult(){
      header('Access-Control-Allow-Origin: *');
      $this->load->model('users');
      $this->load->model('levels');
      $this->load->library('JSend');
      
      $partName   = $this->uri->segment(3);
      $order      = $this->uri->segment(4);
      $username   = isset($_POST['username']) ? $_POST['username'] : null;
      $result     = isset($_POST['result']) ? $_POST['result'] : null;
      $movie      = isset($_FILES["movie"]) ? $_FILES["movie"] : null;
      
      $level = $this->levels->getLevelByOrderPartName($partName, $order);
      $user = $this->users->getUserByUsername($username);

      if(!empty($level) && !empty($user)){
         
         //Calculate score
         $this->load->library('Score');
         $score = $this->Score->grind($level['targetScore'], $result);

         //Check if score is positive
         if($score > 0) {
            //upload video when uploaded
            $movieFileName = null;
            if(!empty($movie)) {
               $this->load->library("upload");
               $this->upload->loadFile($movie);

               if($this->upload->uploadFile() ) {
                  $movieFileName = $this->upload->getFileName();
               }
            }

            //Save challenge result
            $insert['level_id']  = $level['id'];
            $insert['user_id']   = $user['id'];
            $insert['score']     = $score;
            $insert['data']      = $result;
            $insert['movie']     = $movieFileName;
            $this->db->insert("Level_completed", $insert);

            $this->JSend->data = $score;
            echo $this->JSend->getJson();
            return;
         }

      }
      $this->JSend->setStatus(JSend::$FAIL);
      $this->JSend->data = "Failed uplouding challenge!";
      echo $this->JSend->getJson();
   }

   	// function uploadMovie(){
   	// 	if(isset($_POST['username'])){
   	// 		$username 	= $_POST['username'];
   	// 		$title		= $_POST['title'];

   	// 		$this->db->where("username", $username);
   	// 		$result = $this->db->get("Users");

   	// 		if(!empty($result) && !empty($title) ){
   	// 			$this->load->library("upload");
   	// 			//$this->upload->setValidExtensions("ogg");
   	// 			$this->upload->loadFile($_FILES["movie"]);
   				
   	// 			if($this->upload->uploadFile() ) {
   	// 				$videofilePath = $this->upload->getFilePath();
   	// 				$screencapPath = realpath(__SITE_PATH . '/data/uploads/screencap/').'/'.$this->upload->getFileName().'.png';
   	// 				$cmd = "ffmpeg -i $videofilePath -ss 0 -vframes 5 $screencapPath";
   	// 				exec($cmd);

   	// 				$insert['username'] = $username;
   	// 				$insert['fileName'] = $this->upload->getFileName();
   	// 				$insert['title']	= $title;
   	// 				$insert['saved']	= 1;
   	// 				$this->db->insert("Videos", $insert);
   	// 				echo "1";
   	// 				return;
   	// 			}
   	// 		}
   	// 	}
   	// 	echo "0";
   	// }
}