package modelos;

import java.time.LocalDate; 

public class Locacao {
    private String id;
    private int idCliente;
    private String nomeCliente;
    private int idCarro;
    private String placaCarro;
    private LocalDate dataInicio;
    private LocalDate dataFim;
    private double valorDiaria;
    private double valorTotal;

    public Locacao() {
    }

    public Locacao(int idCliente, String nomeCliente, int idCarro, String placaCarro,
                   LocalDate dataInicio, LocalDate dataFim, double valorDiaria) {
        this.idCliente = idCliente;
        this.nomeCliente = nomeCliente;
        this.idCarro = idCarro;
        this.placaCarro = placaCarro;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
        this.valorDiaria = valorDiaria;
        calcularValorTotal();
    }

    public Locacao(String id, int idCliente, String nomeCliente, int idCarro, String placaCarro,
                   LocalDate dataInicio, LocalDate dataFim, double valorDiaria, double valorTotal) {
        this.id = id;
        this.idCliente = idCliente;
        this.nomeCliente = nomeCliente;
        this.idCarro = idCarro;
        this.placaCarro = placaCarro;
        this.dataInicio = dataInicio;
        this.dataFim = dataFim;
        this.valorDiaria = valorDiaria;
        this.valorTotal = valorTotal;
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getIdCliente() {
        return idCliente;
    }

    public void setIdCliente(int idCliente) {
        this.idCliente = idCliente;
    }

    public String getNomeCliente() {
        return nomeCliente;
    }

    public void setNomeCliente(String nomeCliente) {
        this.nomeCliente = nomeCliente;
    }

    public int getIdCarro() {
        return idCarro;
    }

    public void setIdCarro(int idCarro) {
        this.idCarro = idCarro;
    }

    public String getPlacaCarro() {
        return placaCarro;
    }

    public void setPlacaCarro(String placaCarro) {
        this.placaCarro = placaCarro;
    }

    public LocalDate getDataInicio() {
        return dataInicio;
    }

    public void setDataInicio(LocalDate dataInicio) {
        this.dataInicio = dataInicio;
    }

    public LocalDate getDataFim() {
        return dataFim;
    }

    public void setDataFim(LocalDate dataFim) {
        this.dataFim = dataFim;
        calcularValorTotal();
    }

    public double getValorDiaria() {
        return valorDiaria;
    }

    public void setValorDiaria(double valorDiaria) {
        this.valorDiaria = valorDiaria;
        calcularValorTotal();
    }

    public double getValorTotal() {
        return valorTotal;
    }

    private void setValorTotal(double valorTotal) {
        this.valorTotal = valorTotal;
    }

    
    private void calcularValorTotal() {
        if (dataInicio != null && dataFim != null) {
            int dias = (int) (dataFim.toEpochDay() - dataInicio.toEpochDay());
            if (dias < 0) dias = 0;
            this.valorTotal = dias * valorDiaria;
        } else {
            this.valorTotal = 0.0;
        }
    }
}