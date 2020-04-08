$(document).ready(function() {
	var clic = false;
	var xCoord,
		yCoord = "";
	var canvas = document.getElementById("can");

	var cntx = canvas.getContext("2d");
	cntx.strokeStyle = "black";
	cntx.lineWidth = 50;
	cntx.lineCap = "round";
	cntx.fillStyle = "#fff";
	cntx.fillRect(0, 0, canvas.width, canvas.height);

	$("#can").mousedown(function(canvas) {
		clic = true;
		cntx.save();
		xCoord = canvas.pageX - this.offsetLeft;
		yCoord = canvas.pageY - this.offsetTop;
	});

	$(document).mouseup(function() {
		clic = false;
	});

	$(document).click(function() {
		clic = false;
	});

	$("#can").mousemove(function(canvas) {
		if (clic == true) {
			cntx.beginPath();
			cntx.moveTo(
				canvas.pageX - this.offsetLeft,
				canvas.pageY - this.offsetTop
			);
			cntx.lineTo(xCoord, yCoord);
			cntx.stroke();
			cntx.closePath();
			xCoord = canvas.pageX - this.offsetLeft;
			yCoord = canvas.pageY - this.offsetTop;
		}
	});

	$("#erase").click(function() {
		cntx.strokeStyle = "#fff";
	});

	$("#clear").click(function() {
		cntx.fillStyle = "#fff";
		cntx.fillRect(0, 0, canvas.width, canvas.height);
		cntx.strokeStyle = "black";
		cntx.fillStyle = "#fff";
	});

	$("#submit").click(async function() {
		let res = [];
		let mu = 33.408911169825075,
			sigma = 78.677739760763;
		const imgData = cntx.getImageData(0, 0, canvas.width, canvas.height);
		d = imgData.data;
		for (let i = 0; i < d.length; i += 4) {
			res.push((255 - d[i] - mu) / sigma);
		}
		res = downSample(res);
		const rawResponse = await fetch("/recognize", {
			method: "POST",
			headers: {
				Accept: "application/json",
				"Content-Type": "application/json"
			},
			body: JSON.stringify({ image: res })
		});
		const content = await rawResponse.json();
		$("#res").text(content.res)
		cntx.fillStyle = "#fff";
		cntx.fillRect(0, 0, canvas.width, canvas.height);
		cntx.strokeStyle = "black";
		cntx.fillStyle = "#fff";
	});
});

function downSample(data) {
	let res = [];
	let matrix = [];
	for (let i = 0; i < 560; i++) {
		row = [];
		for (let j = 0; j < 560; j++) {
			row.push(data[i * 560 + j]);
		}
		matrix.push(row);
	}
	for (let x = 0; x < 28; x++) {
		for (let y = 0; y < 28; y++) {
			let total = 0;
			for (let i = x * 20; i < (x + 1) * 20; i++) {
				for (let j = y * 20; j < (y + 1) * 20; j++) {
					x;
					total += matrix[i][j];
				}
			}
			res.push(total / 400);
		}
	}
	return res;
}
