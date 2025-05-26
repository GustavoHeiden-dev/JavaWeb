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

	/*public static List<Cliente> clientes = new ArrayList();

	public static List<Cliente> getClientes() {
		return clientes;
	}

	public static void setClientes(Cliente cliente) {
		clientes.add(cliente);
	}*/

	/*
	 * public static List<Cliente> ClienteDao() { clientes.add(new Cliente(1,
	 * "maria", "maria@gmail.com", "(47)9076-1234")); clientes.add(new Cliente(2,
	 * "jose", "jose@gmail.com", "(47)9076-3412")); clientes.add(new Cliente(3,
	 * "maria", "maria@gmail.com", "(47)9076-12356")); }
	 */

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
}