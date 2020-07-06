package qrData;



public class qrDTO {

	private String id;

	private String time;

	private String la;

	private String lo;

	private String store;

	
	public String getId() {
		return id;
	}
	
	public void setId(String id) {

		this.id = id;

	}
	
	public String getTime() {

		return time;

	}

	public void setTime(String time) {

		this.time = time;

	}

	public String getla() {

		return la;

	}

	public void setla(String la) {

		this.la = la;

	}

	public String getlo() {

		return lo;

	}

	public void setlo(String lo) {

		this.lo = lo;

	}

	public String getStore() {

		return store;

	}

	public void setStore(String store) {

		this.store = store;

	}

	public qrDTO(String id,String time, String la, String lo,

			String store) {
		
		this.id = id;

		this.time = time;

		this.la = la;

		this.lo = lo;

		this.store = store;

	}



}