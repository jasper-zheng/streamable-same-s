autowatch = 1;
inlets = 1;
outlets = 0;

var p = this.patcher

function connect(src_varname, dst_varname, cord_idx_begin, cord_idx_end){
	var src = p.getnamed(src_varname);
    var dst = p.getnamed(dst_varname);
	for (var i = cord_idx_begin; i < cord_idx_end; i++){
    	p.connect(src, i, dst, i);
	}
}

function disconnect(src_varname, dst_varname, cord_idx_begin, cord_idx_end){
	var src = p.getnamed(src_varname);
    var dst = p.getnamed(dst_varname);
	for (var i = cord_idx_begin; i < cord_idx_end; i++){
    	p.disconnect(src, i, dst, i);
	}
}