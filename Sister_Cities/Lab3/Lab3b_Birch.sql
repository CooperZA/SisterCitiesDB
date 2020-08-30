-- Copy unique membership type data from tblPersonSTAGING to tblMembershipType

--Delete from tblMembershipType;

-- copy unique membershiptpe data from tblPersonSTAGING to tblMembershipType
/*Insert into tblMembershipType (MembershipType) Select Distinct MembershipType From tblPersonSTAGING;

--updates table tblmembershipType w/ MembershipTypeID
Update tblPersonSTAGING Set tblPersonSTAGING.MembershipTypeID = tblMembershipType.MembershipTypeID From tblMembershipType;

--Update tblMemberahip Type for isGroup column for corporate and family types
Update tblMembershipType set isGroup = 1 Where MembershipType = 'Corporate' or MembershipType = 'Family';

--Update tblMemberahip Type for isGroup column for individual type
Update tblMembershipType set isGroup = 0 Where MembershipType = 'Individual';

--Update tblMemberahip Type for annualfee column for corporate 
Update tblMembershipType set AnnualFee = 250 where MembershipType = 'Corporate';

--Update tblMemberahip Type for annualfee column for individual type
Update tblMembershipType set AnnualFee = 25 where MembershipType = 'Individual';

--Update tblMemberahip Type for annualfee column for family type
Update tblMembershipType set AnnualFee = 50 where MembershipType = 'Family';

--insert values for membershiptype, annualfee, and isgroup for type patron
Insert into tblMembershipType (MembershipType, AnnualFee, isGroup) values ('Patron', 100, 0);

--insert values for membershiptype, annualfee, and isgroup for type student 
Insert into tblMembershipType (MembershipType, AnnualFee, isGroup) values ('Student', 10, 0);*/


--req 3.10b

/*--copy unique membership data from tblPersonSTAGING to tblMembership
Insert into tblMembership (MembershipNumber, isCurrent, MembershipTypeID) Select Distinct MembershipNumber, isCurrentMember, MembershipTypeID From tblPersonSTAGING;

-- Bulk Update tblmembership
Update tblPersonSTAGING Set tblPersonSTAGING.MembershipID = tblMembership.MembershipID From tblMembership;*/

--req 3.10c
--populate tblPerson
/*Insert into tblPerson (FirstName, MidName, LastName, Address, City, State, Zip, AreaCode, Phone, EMail, MembershipID) Select FirstName, MidName, LastName, Address, City, State, Zip, AreaCode, Phone, Email, MembershipID From tblPersonSTAGING;*/