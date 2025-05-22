package Dao;

import java.util.ArrayList;
import java.util.List;

import modelos.Cliente;

public class ClienteDao {
	
	public static List<Cliente> clientes = new ArrayList<>();
    private static int contador = 1; 

   
    public static void adicionarCliente(Cliente cliente) {
        cliente.setId(contador++);
        clientes.add(cliente);
    }


    public static List<Cliente> getClientes() {
        return clientes;
    }
}
