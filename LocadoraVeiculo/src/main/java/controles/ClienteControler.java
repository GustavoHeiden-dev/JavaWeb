package controles;

import java.util.List;

import Dao.ClienteDao;
import modelos.Cliente;

public class ClienteControler {
	
	private ClienteDao clienteDao;
	
	public ClienteControler( ClienteDao clienteDao) {
		this.clienteDao = clienteDao;
	}
	
	public List<Cliente> getAlll(){
		return this.clienteDao.clientes;
	}
}
