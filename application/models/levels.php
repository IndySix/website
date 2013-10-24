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
}