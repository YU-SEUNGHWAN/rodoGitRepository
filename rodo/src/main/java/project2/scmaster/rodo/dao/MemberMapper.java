package project2.scmaster.rodo.dao;


import project2.scmaster.rodo.vo.Member;

public interface MemberMapper 
{
	public int insert(Member member);
	
	public Member selectOne(String id);
	
	public String findid(String email);
	
	public String emailcheck(String email);
	
	public int update(Member member);
	
	public int updatepw(Member member);
	
	
}