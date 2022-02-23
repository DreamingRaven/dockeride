# Sample python file to check syntax highlighting and language server
import platform


class Sample():
    """Sample Python class."""

    def __init__(self, arg=None):
        """Another doc string for the class."""
        self.mproperty = arg if arg is not None else 0

    @property
    def mproperty(self):
        if self.__dict__.get("_mproperty") is None:
            self._mproperty = 1
        return self._mproperty

    @mproperty.setter
    def mproperty(self, new):
        self._mproperty = new


def main():
    """Sample function for highlighting and completion testing."""
    print("External package syntax highlighting: {}".format(
        platform.platform()))
    print("Internal class syntax highlighting and completion: {}".format(
        Sample(arg=10).mproperty
        ))

    if("purposefully poor formatting"==None):
        pass


if __name__ == "__main__":
    main()
