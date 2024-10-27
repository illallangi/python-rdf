import diffsync


class Airline(diffsync.DiffSyncModel):
    iata: str

    label: str
    icao: str | None
    alliance__name: str | None
    dominant_color: str | None

    _modelname = "Airline"
    _identifiers = ("iata",)
    _attributes = (
        "alliance__name",
        "dominant_color",
        "icao",
        "label",
    )

    @classmethod
    def create(
        cls,
        adapter: diffsync.Adapter,
        ids: dict,
        attrs: dict,
    ) -> "Airline":
        raise NotImplementedError

    def update(
        self,
        attrs: dict,
    ) -> "Airline":
        raise NotImplementedError

    def delete(
        self,
    ) -> "Airline":
        raise NotImplementedError
