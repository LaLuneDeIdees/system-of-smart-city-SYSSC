const sqlite3 = require('sqlite3').verbose();
const gl_db = new sqlite3.Database('smartparking.db');
function calling (req,res,data){
	const db = gl_db;
	let dat = '';
	db.each('SELECT * FROM smartparking', function(err,row){
		dat+=row.xy;
	},function complete(err, num){
		res.end(dat);
	});
}
module.exports = {
    calling: calling
};