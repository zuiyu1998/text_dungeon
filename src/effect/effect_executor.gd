class_name EffectExector
extends RefCounted


func apply_effcts(effcts: Array[EffectBuilder]):
	var effct_context_list = effcts.map(func(builder: EffectBuilder): return builder.build())
	var context = EffectContext.new_effct()
	for tmp_context in effct_context_list:
		context.merge(tmp_context)
	apply(context)


func apply(_context: EffectContext):
	pass
