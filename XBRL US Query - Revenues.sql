SELECT distinct on (a.entity_name,element_local_name,f.fiscal_period,effective_value)
e.entity_code, a.entity_name, f.element_local_name,  f.effective_value, f.uom, a.accession_id,
a.document_type,f.fiscal_year, f.fiscal_period, a.filing_date, c.specifies_dimensions,
f.ultimus_index, f.calendar_year, f.calendar_period

FROM accession a
join entity e
	on a.entity_id = e.entity_id
join fact f
	on  f.accession_id = a.accession_id
join context c
	on c.accession_id = a.accession_id and f.context_id = c.context_id

where e.entity_code in('0000320193', '0001018724', '0001067983', '0001166691', '0001326380', '0000354950',
                       '0000200406', '0001045810', '0001318605','0000731766')
and f.element_local_name in('RevenueFromContractWithCustomerExcludingAssessedTax',
                            'RevenueFromContractWithCustomerIncludingAssessedTax','Revenues')
and f.fiscal_year in (2019,2020)
and f.fiscal_period = 'Y'
and f.uom = 'USD'
and a.document_type in ('10-K', '10-K/A')
and c.specifies_dimensions = false
order by entity_name, element_local_name, fiscal_period, effective_value, accession_id, ultimus_index
