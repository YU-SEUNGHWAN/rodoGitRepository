package project2.scmaster.rodo.dao;


import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import project2.scmaster.rodo.vo.Member;

@Repository
public class MemberDao 
{
	@Autowired
	private SqlSession sqlsession;
	
	public int insert(Member member)
	{
		MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
		
		int result = mapper.insert(member);
		
		return result;
	}
	
	public Member selectOne(String id)
	{
		MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
		
		Member member = mapper.selectOne(id);
		
		return member;
	}
	
	public String findid(String email)
	{
		MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
		
		String id = mapper.findid(email);
		
		return id;
	}
	
	public String emailcheck(String email)
	{
		MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
		
		String foundemail = mapper.emailcheck(email);
		
		return foundemail;
	}
	
	public int update(Member member)
	{
		MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
		
		int result = mapper.update(member);
		
		return result;
	}
	
	public int updatepw(Member member)
	{
		MemberMapper mapper = sqlsession.getMapper(MemberMapper.class);
		
		int result = mapper.updatepw(member);
		
		return result;
	}
}