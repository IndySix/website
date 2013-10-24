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
}