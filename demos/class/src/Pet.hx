package;

import cpp.ConstCharStar;

class Pet {
	private var name:ConstCharStar;

	public function new(name:String) {
		this.name = name;
		trace(name);
	}

	public function getName():ConstCharStar {
		trace(name);
		return name;
	}

	public function setName(name:String):Void {
		this.name = name;
	}
}
