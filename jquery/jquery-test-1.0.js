// template
$().each(function() {

});

/*
$(".tbody-dw .searchLine").each(function(index) {
  console.log(index);
});

$(".searchLine .tb-w25 a").each(function(index) {
  console.log(index);
});

$(".searchLine .tb-w25 a").each(function(index) {
  console.log($(this).parent().parent().text());
});*/


// 소스 수정 정보 리스트
$(".tb-w62.td-pl-60").each(function(index) {
  var path = $("#sm_" + index).text().trim();
  var fileName = $(".tb-w30.td-pl-60:eq(" + index + ")").text().trim();
  console.log("." + path + fileName);
});


// 소스 선택 리스트
$(".searchLine .tb-w25 a").each(function(index) {
  var selectName = $(this).text().trim();
  var selectPath = $(this).parent().next("td").text().trim();
  console.log(selectPath + selectName);
});


var array1 = ["./NGS_Source/ngs-ar-app/ngs-ar-biz/src/main/java/ngs/ar/ar/biz/rs/ARAcumNetPrmBiz.java",
  "./NGS_Source/ngs-ar-app/ngs-ar-biz/src/main/java/ngs/ar/ar/biz/rs/ARPadExmpRatBiz.java"
];
var array2 = ["./NGS_Source/ngs-ar-app/ngs-ar-biz/src/main/java/ngs/ar/ar/biz/rs/ARAcumNetPrmBiz.java",
  "./NGS_Deploy/azlk-banca-qna/WEB-INF/web.xml",
  "./NGS_Deploy/azlk-banca-qna/WEB-INF/weblogic.xml"
];
var difference = [];
var equals = [];
jQuery.grep(array2, function(el) {
  if (jQuery.inArray(el, array1) == -1) {
    difference.push(el);
  } else {
    equals.push(el);
  }
});

alert("불일치 내역 : " + difference + "\n 일치 내역 : " + equals);

//deployListBody = 목록조회
//lockListBody = Deliver 파일 선택 List

var checkedList = $("input[name=dplChk]:checked");
checkedList.each(function(){
		var lockItem = $(this).parent().next();
		var lockItemData = ($(lockItem).text().trim());
		var lockItemPath = $(lockItem.next()).text().replace(lockItemData, "");
		var lockItemPath2 = lockItemPath.substring(0, lockItemPath.length-1);
    console.log(lockItem);
});

// alert(" the equals  is " + equals);

$("dpl_checkAll").not(":disabled").prop("checked", false);


if($('#DeployList').find('input[name=dplChk]').not(":disabled").length == 0) {
		$('#dpl_checkAll').attr('checked', false);
	}

$("input[name=dplChk]").not(":disabled").prop("checked", chk);
$("input[name=dplChk]:not(:disabled)").prop("checked", chk);
