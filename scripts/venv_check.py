import sys


def is_venv():
    return (hasattr(sys, 'real_prefix') or
            (hasattr(sys, 'base_prefix') and sys.base_prefix != sys.prefix))


if not is_venv():
    raise Exception("You need to activate a virtualenv! See readme!")
