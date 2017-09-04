package com.kaika.model;

public class Journal {
    private Integer id;

    private String journal;

    private String press;

    private String orderDate;

    private Integer deleted;

    private String content;
    
    private String image;
    
    @Override
	public String toString() {
		return "Journal [id=" + id + ", journal=" + journal + ", press=" + press + ", orderDate=" + orderDate
				+ ", deleted=" + deleted + ", content=" + content + ", image=" + image + "]";
	}

	public String getImage() {
		return image;
	}

	public void setImage(String image) {
		this.image = image;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getJournal() {
        return journal;
    }

    public void setJournal(String journal) {
        this.journal = journal;
    }

    public String getPress() {
        return press;
    }

    public void setPress(String press) {
        this.press = press;
    }

    public String getOrderDate() {
        return orderDate;
    }

    public void setOrderDate(String orderDate) {
        this.orderDate = orderDate;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }
}