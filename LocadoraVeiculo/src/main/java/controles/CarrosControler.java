package controles;

import java.util.List;

import Dao.ClienteDao;
import Dao.DaoCarros;
import modelos.Carros;
import modelos.Cliente;

public class CarrosControler {
		
private DaoCarros carrosDao;
	/*
	public CarrosControler( DaoCarros carrosDao) {
		this.carrosDao = carrosDao;
	}
	
	public List<Carros> getAlll(){
		return this.carrosDao.carros;
	}*/
	public List<Carros> getAll(){
	return DaoCarros.getAll();
}

	public Carros salvar(Carros carros) {
	/*cliente.setId(clienteDao.clientes.size()+1);
	clienteDao.clientes.add(cliente);*/
	DaoCarros.insert(carros);
	return carros;
}
}	
