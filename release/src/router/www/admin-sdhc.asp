<!DOCTYPE HTML PUBLIC '-//W3C//DTD HTML 4.0//EN'>
<!--
	Tomato GUI
	Copyright (C) 2006-2007 Jonathan Zarate
	http://www.polarcloud.com/tomato/
	For use with Tomato Firmware only.
	No part of this file may be used without permission.
	MMC admin module by Augusto Bott
	Modified by Tomasz Słodkowicz for SDHC/MMC driver v2.0.1
-->
<html>
<head>
<meta http-equiv='content-type' content='text/html;charset=utf-8'>
<meta name='robots' content='noindex,nofollow'>
<title>[<% ident(); %>] Admin: SDHC/MMC</title>
<link rel='stylesheet' type='text/css' href='tomato.css'>
<link rel='stylesheet' type='text/css' href='color.css'>
<script type='text/javascript' src='tomato.js'></script>

<!-- / / / -->

<script type='text/javascript' src='debug.js'></script>

<script type='text/javascript'>

//	<% nvram("mmc_on,mmc_fs_partition,mmc_fs_type,mmc_exec_mount,mmc_exec_umount,mmc_cs,mmc_clk,mmc_din,mmc_dout"); %>

var mmc_once_enabled=nvram.mmc_on;

function verifyFields(focused, quiet)
{
	var a = (E('_f_show_info').checked ? '' : 'none');
	var b = !E('_f_mmc_on').checked;
	var c, cs, cl, di, du, e;
	switch (E('_f_mmc_model').value) {
		case '2' :
			E('_f_mmc_cs').value = '7';
			E('_f_mmc_clk').value = '3';
			E('_f_mmc_din').value = '5';
			E('_f_mmc_dout').value = '4';
			c=1;
			break;
		case '3' :
		case '4' :
			E('_f_mmc_cs').value = '7';
			E('_f_mmc_clk').value = '3';
			E('_f_mmc_din').value = '2';
			E('_f_mmc_dout').value = '4';
			c=1;
			break;
		default :
			cs = E('_f_mmc_cs').value;
			cl = E('_f_mmc_clk').value;
			di = E('_f_mmc_din').value;
			du = E('_f_mmc_dout').value;
			e=0;
	}
	E('_f_mmc_model').disabled = b;
	E('_f_mmc_cs').disabled = b || c;
	E('_f_mmc_clk').disabled = b || c;
	E('_f_mmc_din').disabled = b || c;
	E('_f_mmc_dout').disabled = b || c;
	E('_f_mmc_fs_partition').disabled = b;
	E('_f_mmc_fs_type').disabled = b;
	E('_f_mmc_exec_mount').disabled = b;
	E('_f_mmc_exec_umount').disabled = b;
	E('i1').style.display = a;
	E('i2').style.display = a;
	E('i3').style.display = a;
	E('i4').style.display = a;
	E('i5').style.display = a;
	E('i6').style.display = a;
	E('i7').style.display = a;
	E('i8').style.display = a;
	E('i9').style.display = a;
	E('i10').style.display = a;
	E('i11').style.display = a;
	E('i12').style.display = a;
	ferror.clear('_f_mmc_cs');
	ferror.clear('_f_mmc_clk');
	ferror.clear('_f_mmc_din');
	ferror.clear('_f_mmc_dout');
	if (!c) {
	if (!cmpInt(cs,cl)) {
		ferror.set('_f_mmc_cs', 'GPIO must be unique', quiet);
		ferror.set('_f_mmc_clk', 'GPIO must be unique', quiet);
		e=1;
	}
	if (!cmpInt(cs,di)) {
		ferror.set('_f_mmc_cs', 'GPIO must be unique', quiet);
		ferror.set('_f_mmc_din', 'GPIO must be unique', quiet);
		e=1;
	}
	if (!cmpInt(cs,du)) {
		ferror.set('_f_mmc_cs', 'GPIO must be unique', quiet);
		ferror.set('_f_mmc_dout', 'GPIO must be unique', quiet);
		e=1;
	}
	if (!cmpInt(cl,di)) {
		ferror.set('_f_mmc_clk', 'GPIO must be unique', quiet);
		ferror.set('_f_mmc_din', 'GPIO must be unique', quiet);
		e=1;
	}
	if (!cmpInt(cl,du)) {
		ferror.set('_f_mmc_clk', 'GPIO must be unique', quiet);
		ferror.set('_f_mmc_dout', 'GPIO must be unique', quiet);
		e=1;
	}
	if (!cmpInt(di,du)) {
		ferror.set('_f_mmc_din', 'GPIO must be unique', quiet);
		ferror.set('_f_mmc_dout', 'GPIO must be unique', quiet);
		e=1;
	}
	if (e) return 0;
	}
	return 1;
}

function save()
{
	if (!verifyFields(null, 0)) return;
	var fom = E('_fom');
	var on = E('_f_mmc_on').checked ? 1 : 0;
	fom.mmc_on.value = on;
	fom.mmc_cs.value = fom.f_mmc_cs.value;
	fom.mmc_clk.value = fom.f_mmc_clk.value;
	fom.mmc_din.value = fom.f_mmc_din.value;
	fom.mmc_dout.value = fom.f_mmc_dout.value;
	fom.mmc_fs_partition.value = fom.f_mmc_fs_partition.value;
	fom.mmc_fs_type.value = fom.f_mmc_fs_type.value;
	fom.mmc_exec_mount.value = fom.f_mmc_exec_mount.value;
	fom.mmc_exec_umount.value = fom.f_mmc_exec_umount.value;
	form.submit(fom, 1);
}

function submit_complete()
{
	reloadPage();
}
</script>

</head>
<body>
<form id='_fom' method='post' action='tomato.cgi'>
<table id='container' cellspacing=0>
<tr><td colspan=2 id='header'>
	<div class='title'>Tomato</div>
	<div class='version'>Version <% version(); %></div>
</td></tr>
<tr id='body'><td id='navi'><script type='text/javascript'>navi()</script></td>
<td id='content'>
<div id='ident'><% ident(); %></div>

<!-- / / / -->

<input type='hidden' name='_nextpage' value='admin-sdhc.asp'>
<input type='hidden' name='_nextwait' value='10'>
<input type='hidden' name='_service' value='mmc-restart'>
<input type='hidden' name='_commit' value='1'>

<input type='hidden' name='mmc_on'>
<input type='hidden' name='mmc_cs'>
<input type='hidden' name='mmc_clk'>
<input type='hidden' name='mmc_din'>
<input type='hidden' name='mmc_dout'>
<input type='hidden' name='mmc_fs_partition'>
<input type='hidden' name='mmc_fs_type'>
<input type='hidden' name='mmc_exec_mount'>
<input type='hidden' name='mmc_exec_umount'>

<div class='section-title'>SDHC/MMC</div>
<div class='section'>
<script type='text/javascript'>
// <% statfs("/mmc", "mmc"); %>

mmcid = {
	type: 'SDHC',
	spec: '2.0',
	csize: '1000 MB',
	bsize: '512 bytes',
	blocks: '4665476',
	volt: '2.7-3.6',
	manuf: '02',
	appl: 'TM',
	prod: 'SD04G',
	rev: '3.1',
	serial: 'b313e7a0',
	mdate: 'Jun 2008',
};

mmcon = (nvram.mmc_on == 1);
createFieldTable('', [
	{ title: 'Enable', name: 'f_mmc_on', type: 'checkbox', value: mmcon },
	{ text: 'GPIO pins configuration' },
	{ title: 'Router model', name: 'f_mmc_model', type: 'select', options: [[1,'custom'],[2,'WRT54G up to v3.1'],[3,'WRT54G v4.0 and later'],[4,'WRT54GL']], value: 1 },
	{ title: 'Chip select (CS)', indent: 2, name: 'f_mmc_cs', type: 'select', options: [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]], value: nvram.mmc_cs },
	{ title: 'Clock (CLK)', indent: 2, name: 'f_mmc_clk', type: 'select', options: [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]], value: nvram.mmc_clk },
	{ title: 'Data in (DI)', indent: 2, name: 'f_mmc_din', type: 'select', options: [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]], value: nvram.mmc_din },
	{ title: 'Data out (DO)', indent: 2, name: 'f_mmc_dout', type: 'select', options: [[1,1],[2,2],[3,3],[4,4],[5,5],[6,6],[7,7]], value: nvram.mmc_dout },
	null,
	{ text: 'Partition mounting' },
	{ title: 'Partition number', indent: 2, name: 'f_mmc_fs_partition', type: 'select', options: [[1,1],[2,2],[3,3],[4,4]], value: nvram.mmc_fs_type },
	{ title: 'Filesystem', indent: 2, name: 'f_mmc_fs_type', type: 'select', options: [['ext2','ext2'],['ext3','ext3'],['vfat','vfat']], value: nvram.mmc_fs_type },
	{ title: 'Execute after mount', indent: 2, name: 'f_mmc_exec_mount', type: 'text', maxlen: 64, size: 34, value: nvram.mmc_exec_mount },
	{ title: 'Execute before umount', indent: 2, name: 'f_mmc_exec_umount', type: 'text', maxlen: 64, size: 34, value: nvram.mmc_exec_umount },
	{ title: 'Total / Free Size', indent: 2, text: (scaleSize(mmc.size) + ' / ' + scaleSize(mmc.free) + ' <small>(' + (mmc.free/mmc.size*100).toFixed(2) + '%)</small>'), hidden: !mmc.size },
	null,
	{ title: 'Card Identification', name: 'f_show_info', type: 'checkbox', value: 0, hidden: !mmcid.type_ },
	{ title: 'Card type', indent: 2, rid: 'i1', text: mmcid.type },
	{ title: 'Specification version', indent: 2, rid: 'i2', text: mmcid.spec },
	{ title: 'Card size', indent: 2, rid: 'i3', text: mmcid.csize },
	{ title: 'Block size', indent: 2, rid: 'i4', text: mmcid.bsize },
	{ title: 'Number of blocks', indent: 2, rid: 'i5', text: mmcid.blocks },
	{ title: 'Voltage range', indent: 2, rid: 'i6', text: mmcid.volt },
	{ title: 'Manufacture ID', indent: 2, rid: 'i7', text: mmcid.manuf },
	{ title: 'Application ID', indent: 2, rid: 'i8', text: mmcid.appl },
	{ title: 'Product name', indent: 2, rid: 'i9', text: mmcid.prod },
	{ title: 'Revision', indent: 2, rid: 'i10', text: mmcid.rev },
	{ title: 'Serial number', indent: 2, rid: 'i11', text: mmcid.serial },
	{ title: 'Manufacture date', indent: 2, rid: 'i12', text: mmcid.mdate },
	{ title: 'Card Identification', text: '<a href="/mmc/card_id.txt?_http_id=<% nv(http_id); %>">download</a>', hidden: !mmc.size  }
]);
</script>
</div>

<script type='text/javascript'>show_notice1('<% notice("mmc"); %>');</script>

<!-- / / / -->

</td></tr>
<tr><td id='footer' colspan=2>
	<span id='footer-msg'></span>
	<input type='button' value='Save' id='save-button' onclick='save()'>
	<input type='button' value='Cancel' id='cancel-button' onclick='javascript:reloadPage();'>
</td></tr>
</table>
</form>
<script type='text/javascript'>verifyFields(null, 1);</script>
</body>
</html>
