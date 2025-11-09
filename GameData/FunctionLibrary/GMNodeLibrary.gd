class_name GMNodeLibrary

static func HaveChildOfType(parent : Node, asType) -> Array:
	var ChildrenOfType = parent.get_children(true).map(func(child): return is_instance_of(child, asType))
	if ChildrenOfType.is_empty():
		return []
	return ChildrenOfType
