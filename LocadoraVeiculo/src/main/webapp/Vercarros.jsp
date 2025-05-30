<%@page import="controles.CarrosControler"%>
<%@page import="Dao.DaoCarros"%>
<%@page import="modelos.Carros"%>
<%@page import="controles.ClienteControler"%>
<%@page import="Dao.ClienteDao"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<%
    String placa = request.getParameter("placa");
    if (placa != null) {
        String marca = request.getParameter("marca");
        String modelo = request.getParameter("modelo");
        String ano = request.getParameter("ano");
        String cor = request.getParameter("cor");

     	Carros carro = new Carros();
     	carro.setPlaca(placa);
     	carro.setMarca(marca);
     	carro.setModelo(modelo);
     	carro.setAno(ano);
     	carro.setCor(cor);
     	CarrosControler caControler = new CarrosControler();
     	caControler.salvar(carro);

        response.sendRedirect("Consulta.jsp");
        return;
    }
%>
</body>
</html>