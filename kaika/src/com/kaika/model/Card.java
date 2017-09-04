package com.kaika.model;

import java.util.Date;

public class Card {
    private Integer id;

    private String number;

    private String password;

    private Integer status;

    private String orderDate;

    private String name;

    private String school;

    private String mobile;

    private Integer zipcode;

    private Integer region;

    private Integer street;

    private String road;

    private String doorplate;

    private String room;

    private Date activationTime;

    private String jouranl;

    private Date createTime;

    private Date editTime;

    private String remark;

    private Integer deleted;
    
    private String regionName;
	
	private String streetName;
	
	@Override
	public String toString() {
		return "Card [id=" + id + ", number=" + number + ", password=" + password + ", status=" + status
				+ ", orderDate=" + orderDate + ", name=" + name + ", school=" + school + ", mobile=" + mobile
				+ ", zipcode=" + zipcode + ", region=" + region + ", street=" + street + ", road=" + road
				+ ", doorplate=" + doorplate + ", room=" + room + ", activationTime=" + activationTime + ", jouranl="
				+ jouranl + ", createTime=" + createTime + ", editTime=" + editTime + ", remark=" + remark
				+ ", deleted=" + deleted + ", regionName=" + regionName + ", streetName=" + streetName + "]";
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	public String getStreetName() {
		return streetName;
	}

	public void setStreetName(String streetName) {
		this.streetName = streetName;
	}

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getMobile() {
        return mobile;
    }

    public void setMobile(String mobile) {
        this.mobile = mobile;
    }

    public Integer getZipcode() {
        return zipcode;
    }

    public void setZipcode(Integer zipcode) {
        this.zipcode = zipcode;
    }

    public Integer getRegion() {
        return region;
    }

    public void setRegion(Integer region) {
        this.region = region;
    }

    public Integer getStreet() {
        return street;
    }

    public void setStreet(Integer street) {
        this.street = street;
    }

    public String getRoad() {
        return road;
    }

    public void setRoad(String road) {
        this.road = road;
    }

    public String getDoorplate() {
        return doorplate;
    }

    public void setDoorplate(String doorplate) {
        this.doorplate = doorplate;
    }

    public String getRoom() {
        return room;
    }

    public void setRoom(String room) {
        this.room = room;
    }

    public Date getActivationTime() {
        return activationTime;
    }

    public void setActivationTime(Date activationTime) {
        this.activationTime = activationTime;
    }

    public String getJouranl() {
        return jouranl;
    }

    public void setJouranl(String jouranl) {
        this.jouranl = jouranl;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getEditTime() {
        return editTime;
    }

    public void setEditTime(Date editTime) {
        this.editTime = editTime;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }
}