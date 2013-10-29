<?php if (!defined('__SITE_PATH')) exit('No direct script access allowed');

class levels extends model{

	public function getLevelById($id){
		$this->db->reset();
		$this->db->where('id', $id);
		$level = $this->db->get('Levels');
		if(!empty($level))
			return $level[0];
		return null;
	}

	public function getCompletedLevelsByLevelId($id, $count = 10){
		if(!is_numeric($count))
			$count = 10;
		$sql = "SELECT Level_completed.*, Users.username as username FROM Level_completed, Users WHERE Users.id = Level_completed.user_id AND level_id = ? ORDER BY score DESC LIMIT 0, ".$count;
		$bind[] = $id;
		$data = $this->db->query($sql, $bind);
		if(!empty($data)){
			return $data;
		}
		return null;
	}
	public function getLatestCompletedLevelsByPartName($name){
		$this->db->reset();
		$this->db->where("name",$name);
		$result = $this->db->get("Parts");

		if(!empty($result)){
			$sql  = "SELECT Levels.order as level,  Users.username as username, Level_completed.score as score";
			$sql .= " FROM Users, Level_completed, Levels";
			$sql .= " WHERE Users.id = Level_completed.user_id AND Levels.id = Level_completed.level_id AND part_id = ".$result[0]['id']." ORDER BY Level_completed.id DESC LIMIT 0, 10";
			$data = $this->db->query($sql);
			if(!empty($data))
				return $data;
		}
		return null;
	}
	public function getTopScoreUserLevel($id) {
		$sql = "SELECT max(score) as score FROM Level_completed WHERE user_id = ?";
		$bind[] = $id;
		$data = $this->db->query($sql, $bind);
		if(!empty($data)){
			return $data[0];
		}
		return null;
	}
	public function getLevelAttemptUser($id){
		$sql = "SELECT count(*) as attempt FROM Level_completed WHERE user_id = ?";
		$bind[] = $id;
		$data = $this->db->query($sql, $bind);
		if(!empty($data)){
			return (int) $data[0]['attempt']+1;
		}
		return 0;
	}
}