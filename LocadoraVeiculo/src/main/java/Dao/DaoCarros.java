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
   

   /*
    public static void adicionarCarro(Carros carro) {
        carros.add(carro);
    }


    public static List<Carros> getCarro() {
        return carros;
    }*/
	
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
				carros.add(new Carros(rs.getString("placa"),rs.getString("marca"),rs.getString("modelo"),rs.getString("ano"),rs.getString("cor")));
			}
		} catch (Exception e) {
			throw new RuntimeException(e.getMessage());
		}
		return carros;
	}

	
}

