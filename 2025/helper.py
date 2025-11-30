# This file contains helper functions

import logging
import socket
from typing import Callable

import coloredlogs

__all__ = [
    "verify_answer",
    "setup_logger",
]


def setup_logger(name: str | None = None, level: str = "INFO") -> logging.Logger:
    """Setup colored logging for the module."""

    # Get hostname
    hostname = socket.gethostname()

    # Add SUCCESS level before configuring coloredlogs
    SUCCESS_LEVEL = 25  # Between INFO (20) and WARNING (30)
    logging.addLevelName(SUCCESS_LEVEL, "SUCCESS")

    # Configure the root logger to use coloredlogs with default styling
    coloredlogs.install(
        level=level,
        fmt=f"%(asctime)s [{hostname}] %(name)s[%(process)d] %(levelname)s %(message)s",
    )

    # Get or create logger
    if name:
        logger = logging.getLogger(name)
    else:
        logger = logging.getLogger(__name__)

    logger.setLevel(level)

    # Add success method to Logger class
    def success(self, message, *args, **kws):
        if self.isEnabledFor(SUCCESS_LEVEL):
            self._log(SUCCESS_LEVEL, message, args, **kws)

    logging.Logger.success = success
    return logger


def verify_answer(f: Callable[[str], int], example_input: str, expected_answer: int) -> None:
    """Verify the answer"""
    # Create a logger if not already available
    logger = logging.getLogger(__name__)

    result = f(example_input)
    if result == expected_answer:
        logger.success(f"That's right! The answer is {expected_answer}.")
    else:
        logger.error(f"Expected {expected_answer}, but got {result}.")
