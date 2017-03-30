<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>

function output(resp) 
{
	var data = '<table>';
	
	$.each(resp, function(index, item)
	{
		data += '<tr class="reviewtr" data-sno="'+ item.seq +'" >';
		data += '   <td class="seq">' + item.seq + '</td>';
		data += '   <td class="name">' + item.name + '</td>';
		data += '   <td class="regdate">' + item.regdate + '</td>';
		data += '   <td class="review">' + item.review + '</td>';
		data += '   <td><input type="button" class="delbtn" data-sno="'+item.seq +'"value="삭제" /></td>';
		data += '</tr>';
	});
		data += '</table>';   
		$("#reviewDiv").html(data);
		$(".delbtn").on('click', del);
}

</script>

</head>
<body>



</body>
</html>