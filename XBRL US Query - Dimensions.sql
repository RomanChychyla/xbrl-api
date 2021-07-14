SELECT distinct
e.entity_code, a.entity_name, f.element_local_name, q1.local_name as dimension, q2.local_name as member,
f.effective_value, f.uom, a.accession_id, a.document_type,
f.fiscal_year, f.fiscal_period, a.filing_date, c.specifies_dimensions,
f.ultimus_index, f.calendar_year, f.calendar_period

FROM accession a
join entity e
	on a.entity_id = e.entity_id
join fact f
	on  f.accession_id = a.accession_id
join context c
	on c.accession_id = a.accession_id and f.context_id = c.context_id
join context_dimension d
	on c.context_id = d.context_id
join qname q1
	on d.dimension_qname_id = q1.qname_id
join qname q2
	on d.member_qname_id = q2.qname_id

where e.entity_code in ('0000320193', '0001067983', '0001318605')
and f.element_local_name in ('RevenueFromContractWithCustomerExcludingAssessedTax',
							 'RevenueFromContractWithCustomerIncludingAssessedTax')
and q1.local_name = 'ProductOrServiceAxis' -- dimension
and q2.local_name = 'ServiceMember' -- axis
and f.fiscal_year  = 2020
and f.fiscal_period = 'Y'
and f.uom = 'USD'
and a.document_type in ('10-K', '10-K/A')
and f.is_extended = false
and c.specifies_dimensions = true
order by a.entity_name, f.element_local_name, f.fiscal_year
