package;

class Pet {
	private var name:String;

	public function new() {
		this.name = "a";
	}

	public function getName(self:String):String {
		trace(name);
		return name;
	}

	public function setName(name:String):Void {
		this.name = name;
	}
}
