class ConvertSend {
  ConvertSend(
      {rawContent: '',
      format: '',
      type: '',
      formatNote: '',
      indexNumber: '700507',
      studentName: 'Ebenezer Agbekeye',
      studentClass: '2022'}) {
    Map tobeSent;
    tobeSent = {
      rawContent,
      format,
      type,
      formatNote,
      indexNumber,
      studentName,
      studentClass
    } as Map;
    _sendToDB(tobeSent);
  }
  _sendToDB(data) {
    print(data);
  }
}


