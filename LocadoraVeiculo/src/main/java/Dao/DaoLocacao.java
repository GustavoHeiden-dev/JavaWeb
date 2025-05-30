package Dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

import modelos.Carros;
import modelos.Locacao;
import utils.ConexaoDB;

public class DaoLocacao {

    public static Locacao insert(Locacao locacao) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = ConexaoDB.getConexao();
            String sql = "INSERT INTO Locacoes (idCliente, nomeCliente, idCarro, placaCarro, dataInicio, dataFim, valorDiaria, valorTotal) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            stm = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS);

            stm.setInt(1, locacao.getIdCliente());
            stm.setString(2, locacao.getNomeCliente());
            stm.setInt(3, locacao.getIdCarro());
            stm.setString(4, locacao.getPlacaCarro());
            stm.setDate(5, java.sql.Date.valueOf(locacao.getDataInicio()));
            stm.setDate(6, java.sql.Date.valueOf(locacao.getDataFim()));
            stm.setDouble(7, locacao.getValorDiaria());
            stm.setDouble(8, locacao.getValorTotal());
            stm.executeUpdate();
            ResultSet rs = stm.getGeneratedKeys();
            if (rs.next()) {
                locacao.setId(String.valueOf(rs.getInt(1)));
            }

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao inserir Locação: " + e.getMessage());
        }
        return locacao;
    }

    public static List<Locacao> getAll() {
    	 List<Locacao> locacoes = new ArrayList<>();
         Connection con = null;
         PreparedStatement stm = null;
         ResultSet rs = null;
         try {
             con = ConexaoDB.getConexao();
             String sql = "SELECT id, idCliente, nomeCliente, idCarro, placaCarro, dataInicio, dataFim, valorDiaria, valorTotal FROM Locacoes";
             stm = con.prepareStatement(sql);
             rs = stm.executeQuery();

             while (rs.next()) {
                 Locacao locacao = new Locacao(
                     String.valueOf(rs.getInt("id")), rs.getInt("idCliente"),rs.getString("nomeCliente"),rs.getInt("idCarro"),rs.getString("placaCarro"),
                     rs.getDate("dataInicio").toLocalDate(),rs.getDate("dataFim").toLocalDate(),rs.getDouble("valorDiaria"),rs.getDouble("valorTotal")
                 );
                 locacoes.add(locacao);
             }
         } catch (SQLException e) {
             e.printStackTrace();
             throw new RuntimeException("Erro ao buscar todas as Locações: " + e.getMessage());
         } finally {
             try {
                 if (rs != null) rs.close();
                 if (stm != null) stm.close();
                 if (con != null) con.close();
             } catch (SQLException e) {
                 e.printStackTrace();
             }
         }
         return locacoes;
    }
    
    public static void delete(int id) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = ConexaoDB.getConexao();
            String sql = "DELETE FROM Locacoes WHERE id = ?";
            stm = con.prepareStatement(sql);
            stm.setInt(1, id);
            stm.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("Erro ao deletar locacao: " + e.getMessage());
        } 
  }
    public static void update(Locacao loca) {
		 Connection con = null;
		    PreparedStatement stm = null;
		    try {
		        con = ConexaoDB.getConexao();
		        
		        String sql = "UPDATE Locacoes SET idCliente = ?, nomeCliente = ?, idCarro = ?, placaCarro = ?, dataInicio = ? dataFim = ? valorDiaria = ? "
		        		+ "valorTotal = ? WHERE id = ?";
		        stm = con.prepareStatement(sql);
		        stm.setInt(1, loca.getIdCliente());
		        stm.setString(2, loca.getNomeCliente());
		        stm.setInt(3, loca.getIdCarro());
		        stm.setString(4, loca.getPlacaCarro());
		        stm.setObject(5, loca.getDataInicio());
		        stm.setObject(6, loca.getDataFim());
		        stm.setDouble(7, loca.getValorDiaria());
		        stm.setDouble(8, loca.getValorTotal());
		        stm.setInt(9, Integer.parseInt(loca.getId()));
		        stm.executeUpdate();
		    } catch (SQLException e) {
		        e.printStackTrace();
		        throw new RuntimeException("Erro ao atualizar Locaçao: " + e.getMessage());
		    } 
	 	}
}
