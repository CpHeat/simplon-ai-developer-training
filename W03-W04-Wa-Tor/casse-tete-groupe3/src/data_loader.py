def load_data():
    return {"status": "ok", "data": ['Alice', 'Bob', 'Charlie']}

from datetime import datetime
def  load_complete_data():
    
    current_date = datetime.now().strftime('%Y-%m-%d')
    
    return {
    'status': 'ok',
    'data': [],
    'metadata': {
        'author': 'G3',
        'date': 'current_date'
    }
  }

def load_config():
    return {'env': 'dev', 'version': '1.0'}

