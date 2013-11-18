<?php

class person {

var $name = "Stefan";					//  attribute

	function get_name() {				//  method

		return $this->name;  //		stays in memory (model)

//		echo $this->name;  //	user-exposed data (view)
	}

	function set_name($new_name) {

		$this->name = $new_name;
    }

}

?>