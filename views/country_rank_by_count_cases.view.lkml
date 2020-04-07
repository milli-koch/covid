view: country_rank_by_count_cases {
  derived_table: {
    explore_source: summary {
      column: country_region {}
      column: total_confirmed {}
      derived_column: rank {
        sql: RANK() OVER (ORDER BY total_confirmed DESC) ;;
      }
    }
  }

  dimension: country_region {
    primary_key: yes
    hidden: yes
  }

  dimension: total_confirmed {
    hidden: yes
    type: number
  }

  dimension: country_rank {
    description: "Country Ranking by Count of Confirmed Cases"
    view_label: "Summary"
    type: number
    sql: ${TABLE}.rank ;;
  }
}
