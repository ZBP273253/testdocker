package com.service;

import java.util.List;

import mapper.ClssMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import entity.Clas;

@Service
public class ClasService {
	@Autowired()
	private ClssMapper clssMapper;

	@Transactional
	public List<Clas> ClasgetAll(){
		return clssMapper.getClsss();
	}
	/**
	 * 查询所有的id
	 * @param id
	 * @return
	 */
	public Clas getClById(int id) {
		return clssMapper.getClssId(id);
	}
}
