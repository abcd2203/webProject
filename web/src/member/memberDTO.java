package member;



public class memberDTO {


	private String name;

	private String id;

	private String pwd;

	private String address;

	private String age;
	
	private String sex;

	

	public String getName() {

		return name;

	}

	public void setName(String name) {

		this.name = name;

	}

	public String getId() {

		return id;

	}

	public void setId(String id) {

		this.id = id;

	}

	public String getPwd() {

		return pwd;

	}

	public void setPwd(String pwd) {

		this.pwd = pwd;

	}

	public String getAddress() {

		return address;

	}

	public void setAddress(String address) {

		this.address = address;

	}

	public String getAge() {

		return age;

	}

	public void setAge(String age) {

		this.age = age;

	}
	
	public String getSex() {

		return sex;

	}

	public void setSex(String sex) {

		this.sex = sex;

	}

	

	public memberDTO(String name, String id, String pwd,

			String address, String age, String sex) {

		this.name = name;

		this.id = id;

		this.pwd = pwd;

		this.address = address;

		this.age = age;
		
		this.sex = sex;

	}



}