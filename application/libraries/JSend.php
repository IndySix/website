<?PHP
class JSend{
        #status
        public static $SUCCESS  = "success";
        public static $FAIL     = "fail";
        public static $ERROR    = "error";

        #Status of message (success, fail, error)
        private $status;
        public $data;
        public $code;
        public $message;

        function __construct(){
                $this->status = self::$SUCCESS;
        }

        function setStatus($status){
                if($status == self::$SUCCESS || $status == self::$FAIL || $status == self::$ERROR)
                        $this->status = $status;
        }

        function getJson(){
                $jClass = new stdClass;
                $jClass->status = $this->status;

                if($this->status != self::$ERROR){
                        $jClass->data = $this->data;
                } else {
                        $jClass->code = $this->code;
                        $jClass->message = $this->message;
                }
                return json_encode($jClass);
        }
}