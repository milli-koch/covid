view: summary {
  derived_table: {
    sql:
    SELECT
    row_number() OVER(ORDER BY date) AS prim_key,
    *
    FROM `bigquery-public-data.covid19_jhu_csse.summary` ;;
  }

  dimension: prim_key {
    hidden: yes
    type: number
    sql: ${TABLE}.prim_key ;;
  }

  dimension_group: date {
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    datatype: date
    sql: ${TABLE}.date ;;
  }

  #### METRICS

  dimension: confirmed {
    type: number
    sql: ${TABLE}.confirmed ;;
  }

  dimension: deaths {
    type: number
    sql: ${TABLE}.deaths ;;
  }


  #### LOCATIONS

  dimension: country_raw {
    hidden: yes
    type: string
    sql:  ${TABLE}.country_region;;
  }

  dimension: country_region {
    type: string
    sql: case when ${date_date} <= date(2020, 03, 10) and ${country_raw} = "Mainland China"
          then "China"
          else ${country_raw} end;;
    map_layer_name: countries
    # link: {
    #   label: "Filter on {{ value }}"
    #   url: "/dashboards-next/877?Country={{ value }}"
    # }
    html: <a href="/dashboards-next/877?Country={{ value }}">{{ value }}</a> ;;
  }

  dimension: fips {
    type: string
    sql: ${TABLE}.fips ;;
    map_layer_name: us_counties_fips
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude};;
    sql_longitude: ${longitude} ;;
  }

  dimension: province_state {
    type: string
    sql: case when ${TABLE}.province_state like "%,%" then null else ${TABLE}.province_state end ;;
    map_layer_name: us_states
    link: {
      label: "Filter on {{ value }}"
      url: "/dashboards-next/877?State={{ value }}"
    }
  }

  dimension: latitude {
    hidden: yes
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    hidden: yes
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: location_geom {
    hidden: yes
    type: string
    sql: ${TABLE}.location_geom ;;
  }

  dimension: admin2 {
    type: string
    hidden: yes
    sql: ${TABLE}.admin2 ;;
  }

  dimension: combined_key {
    type: string
    hidden: yes
    sql: ${TABLE}.combined_key ;;
  }


  #### MEASURES

  measure: total_confirmed {
    type: sum
    sql: ${confirmed} ;;
  }

  measure: total_deaths {
    type: sum
    sql: ${deaths} ;;
  }

  #### INACTIVE FIELDS

#   dimension: active {
#     type: number
#     sql: cast(${TABLE}.active as int64) ;;
#   }
#
#   dimension: recovered {
#     type: number
#     sql: ${TABLE}.recovered ;;
#   }
#
#   measure: total_active {
#     type: sum
#     sql: ${active} ;;
#   }
#
#   measure: total_recovered {
#     type: sum
#     sql: ${recovered} ;;
#   }

}
