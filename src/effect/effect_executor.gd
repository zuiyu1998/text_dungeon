class_name EffectExector
extends RefCounted


func apply_effcts(effcts: Array[EffectBuilder]):
	var effct_context_list = effcts.map(func(builder: EffectBuilder): return builder.build())
	for context in effct_context_list:
		apply(context)


func apply(_context: EffectContext):
	pass
