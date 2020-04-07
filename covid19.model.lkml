connection: "bigquery"

include: "/views/*.view.lkml"

explore: summary {
  join: country_rank_by_count_cases {
    sql_on: ${country_rank_by_count_cases.country_region} = ${summary.country_region} ;;
    type: left_outer
    relationship: many_to_one
  }
}
