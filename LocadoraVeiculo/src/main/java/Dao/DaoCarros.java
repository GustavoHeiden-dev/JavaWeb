package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.management.RuntimeErrorException;

import modelos.Carros;
import modelos.Cliente;
import utils.ConexaoDB;


public class DaoCarros {
	public static List<Carros> carros = new ArrayList<>();
   

	public static Carros getCarroById(int id) {
		 Carros carro = null;
		    Connection con = null;
		    PreparedStatement stm = null;
		    ResultSet rs = null;
		    try {
		        con = ConexaoDB.getConexao();

		        String sql = "select id, placa, marca, modelo, ano, cor from Carros where id = ?"; 
		        stm = con.prepareStatement(sql);
		        stm.setInt(1, id);
		        rs = stm.executeQuery();
		        if (rs.next()) {
		            carro = new Carros();
		            carro.setId(String.valueOf(rs.getInt("id")));
		            carro.setPlaca(rs.getString("placa"));
		            carro.setMarca(rs.getString("marca"));
		            carro.setModelo(rs.getString("modelo"));
		            carro.setAno(rs.getString("ano"));
		            carro.setCor(rs.getString("cor"));
		        }
		    } catch (SQLException e) { 
		        e.printStackTrace();
		        throw new RuntimeException("Erro ao buscar carro por ID: " + e.getMessage());
		    } finally {
		       
		        try {
		            if (rs != null) rs.close();
		            if (stm != null) stm.close();
		            if (con != null) con.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
		    return carro;
	}
	
	
	public static Carros insert(Carros carro) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "insert into Carros(placa, marca, modelo, ano , cor)" + "values(?,?,?,?,?)";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, carro.getPlaca());
			stm.setString(2, carro.getMarca());
			stm.setString(3, carro.getModelo());
			stm.setString(4, carro.getAno());
			stm.setString(5, carro.getCor());
			stm.execute();

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return carro;
	}

	public static List<Carros> getAll() {
		List<Carros> carros = new ArrayList<Carros>();
		try {
			Connection con = ConexaoDB.getConexao();

			String sql = "select * from Carros";
			PreparedStatement stm = con.prepareStatement(sql);
			ResultSet rs = stm.executeQuery();
			while (rs.next()) {
				carros.add(new Carros(rs.getString("placa"),rs.getString("marca"),rs.getString("modelo"),rs.getString("ano"),rs.getString("cor"), rs.getString("id")));
			}
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return carros;
	}
	 public static void update(Carros carro) {
		 Connection con = null;
		    PreparedStatement stm = null;
		    try {
		        con = ConexaoDB.getConexao();
		        
		        String sql = "UPDATE Carros SET placa = ?, marca = ?, modelo = ?, ano = ?, cor = ? WHERE id = ?";
		        stm = con.prepareStatement(sql);
		        stm.setString(1, carro.getPlaca());
		        stm.setString(2, carro.getMarca());
		        stm.setString(3, carro.getModelo());
		        stm.setString(4, carro.getAno());
		        stm.setString(5, carro.getCor());
		        stm.setInt(6, Integer.parseInt(carro.getId()));
		        stm.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		        throw new RuntimeException("Erro ao atualizar Carros: " + e.getMessage());
		    } finally {
		       
		        try {
		            if (stm != null) stm.close();
		            if (con != null) con.close();
		        } catch (SQLException e) {
		            e.printStackTrace();
		        }
		    }
	 	}
	 
	 public static void delete(int id) {
	        Connection con = null;
	        PreparedStatement stm = null;
	        try {
	            con = ConexaoDB.getConexao();
	            String sql = "DELETE FROM Carros WHERE id = ?";
	            stm = con.prepareStatement(sql);
	            stm.setInt(1, id);
	            stm.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException("Erro ao deletar Carro: " + e.getMessage());
	        } 
	  }
}

