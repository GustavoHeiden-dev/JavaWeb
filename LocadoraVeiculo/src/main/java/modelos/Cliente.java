package modelos;

public class Cliente {

	private String nome;
	private String email;
	private String fone;
	private String id;
	
public Cliente() {
		
	}
	
	public Cliente( String nome, String email, String fone ,String id) {
		super();
		this.nome = nome;
		this.email = email;
		this.fone = fone;
		this.id = id;
	}

	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getNome() {
		return nome;
	}
	public void setNome(String nome) {
		this.nome = nome;
	}
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getFone() {
		return fone;
	}
	public void setFone(String fone) {
		this.fone = fone;
	}
	
	
}
