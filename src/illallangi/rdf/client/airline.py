import rdflib


class AirlineMixin:
    def get_airlines_query(
        self,
        airline_iata: list[str],
    ) -> str:
        return f"""
    SELECT ?label ?iata ?icao WHERE {{
        VALUES (?value) {{ ( "{'" ) ( "'.join([i.upper() for i in airline_iata])}" ) }}
        ?href ip:airlineIataCode ?value.
        ?href rdfs:label ?label .
        ?href ip:airlineIataCode ?iata .
        OPTIONAL {{ ?href ip:airlineIcaoCode ?icao . }}
        ?href a ic:airline .
    }}
    """

    def get_airlines(
        self,
        *_args: list,
        airline_iata: list[str] | None = None,
        **_kwargs: dict,
    ) -> list[dict]:
        if airline_iata is None:
            return []

        result = self.graph.query(
            self.get_airlines_query(
                airline_iata=airline_iata,
            ),
        )

        return [
            {str(k): str(b[str(k)]) if str(k) in b else None for k in result.vars}
            for b in result.bindings
        ]
