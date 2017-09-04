package com.kaika.service.imp;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.kaika.mapper.JournalMapper;
import com.kaika.model.Journal;
import com.kaika.service.JournalService;


@Service
public class JournalServiceImp implements JournalService{

	private JournalMapper journalMapper;
	
	@Autowired 
	public JournalServiceImp(JournalMapper journalMapper) {
		this.journalMapper = journalMapper;
	}

	@Override
	public List<Journal> listJournal(Journal journal) {
		return journalMapper.listByCondition(journal);
	}

	@Override
	public int count(Journal journal) {
		return journalMapper.count(journal);
	}

	@Override
	public boolean saveJournalInfo(Journal journal) {
		int status = journalMapper.insertSelective(journal);
		if(status>0){
			return true;
		}
		return false;
	}

	@Override
	public boolean updateJournalInfo(Journal journal) {
		int status = journalMapper.updateByPrimaryKeySelective(journal);
		if(status>0){
			return true;
		}
		return false;
	}	

	@Override
	public int deleteJournal(Integer uid) {
		return journalMapper.deleteByPrimaryKey(uid);
	}

	@Override
	public boolean updateUseStatus(Journal journal) {
		int status1 = journalMapper.updateUseStatus(journal);
		int status2 = journalMapper.updateOtherStatus(journal);
		if(status1>0 && status2>0){
			return true;
		}
		return false;
	}

	@Override
	public Journal getUseJournal() {
		return journalMapper.getUseJournal();
	}	

}	

