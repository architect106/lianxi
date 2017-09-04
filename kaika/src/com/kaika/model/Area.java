package com.kaika.model;

public class Area {
    private Integer id;

    private Integer pid;

    private String name;

    private Integer priority;

    private Integer deleted;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPriority() {
        return priority;
    }

    public void setPriority(Integer priority) {
        this.priority = priority;
    }

    public Integer getDeleted() {
        return deleted;
    }

    public void setDeleted(Integer deleted) {
        this.deleted = deleted;
    }

	@Override
	public String toString() {
		return "Area [id=" + id + ", pid=" + pid + ", name=" + name + ", priority=" + priority + ", deleted=" + deleted
				+ "]";
	}
    
}