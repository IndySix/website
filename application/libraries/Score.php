<?PHP if (!defined('__SITE_PATH')) exit('No direct script access allowed');
class Score {

	private function calculate($target, $result) {
		$count 				= 0;
		$scorePercentage 	= 0;
		$requiredCompleted 	= true;
		$target_arr = json_decode($target);

		foreach ($target_arr as $key => $item) {
			if(isset($result[$key])){
				$percentage = $result[$key] / $item->value * 100;

				if($item->required)
					$requiredCompleted = $percentage >= 100 ? $requiredCompleted : false;

				$count++;
				$scorePercentage += $percentage;
			}
		}
		return ($requiredCompleted ? (500 * (($scorePercentage/$count) /100) ) : -1);
	}
	
	function grind($target, $result){
		//calculate distance
		$calcResult['distance'] = rand(3, 6);
		//calculate speed
		$calcResult['speed'] = rand(10, 30);

		return (int)$this->calculate($target, $calcResult);
	}

}