package com.kaika.service;

import java.util.List;
import com.kaika.model.Journal;

public interface JournalService {  

	List<Journal> listJournal(Journal journal);

	int count(Journal journal);

	boolean saveJournalInfo(Journal journal);

	boolean updateJournalInfo(Journal journal);

	int deleteJournal(Integer uid);

	boolean updateUseStatus(Journal journal);

	Journal getUseJournal();

}
