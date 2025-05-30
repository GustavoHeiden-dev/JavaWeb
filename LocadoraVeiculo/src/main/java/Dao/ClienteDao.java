package Dao;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import javax.management.RuntimeErrorException;

import modelos.Cliente;
import utils.ConexaoDB;

public class ClienteDao {

	public static Cliente getClienteById(int id) {
		Cliente clientes = new Cliente();
		try {
			Connection con = ConexaoDB.getConexao();

			String sql = "select * from tb_Cliente where id = ?";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setInt(1, id);
			ResultSet rs = stm.executeQuery();
			if (rs.next()) {
				clientes.setId( rs.getString("id"));
				clientes.setNome(rs.getString("nome"));
				clientes.setEmail(rs.getString("email"));
				clientes.setFone(rs.getString("fone"));
			}
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return clientes;
	}
	
	public static Cliente insert(Cliente cliente) {
		try {
			Connection con = ConexaoDB.getConexao();
			String sql = "insert into tb_Cliente(nome, email, fone)" + "values(?,?, ?)";
			PreparedStatement stm = con.prepareStatement(sql);
			stm.setString(1, cliente.getNome());
			stm.setString(2, cliente.getEmail());
			stm.setString(3, cliente.getFone());
			stm.execute();

		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return cliente;
	}

	public static List<Cliente> getAll() {
		List<Cliente> clientes = new ArrayList<Cliente>();
		try {
			Connection con = ConexaoDB.getConexao();

			String sql = "select * from tb_Cliente";
			PreparedStatement stm = con.prepareStatement(sql);
			ResultSet rs = stm.executeQuery();
			while (rs.next()) {
				clientes.add(new Cliente(rs.getString("nome"), rs.getString("email"),
						rs.getString("fone") , rs.getString("id")));
			}
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return clientes;
	}
	  public static void update(Cliente cliente) {
	        Connection con = null;
	        PreparedStatement stm = null;
	        try {
	            con = ConexaoDB.getConexao();
	            String sql = "UPDATE tb_Cliente SET nome = ?, email = ?, fone = ? WHERE id = ?";
	            stm = con.prepareStatement(sql);
	            stm.setString(1, cliente.getNome());
	            stm.setString(2, cliente.getEmail());
	            stm.setString(3, cliente.getFone());
	            stm.setString(4, cliente.getId());
	            stm.executeUpdate();
	        } catch (SQLException e) {
	            e.printStackTrace();
	            throw new RuntimeException("Erro ao atualizar cliente: " + e.getMessage());
	        }
	  }
}
