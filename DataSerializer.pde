import java.nio.ByteBuffer;

static class DataFormat{
    
    static class DataType{
        // Stringなど動的なデータサイズ
        public static final int BYTE_SIZE_DYNAMIC = -1;
        int byteSize;
        Converter converter;
        private DataType(int byteSize,Converter converter) {
            this.byteSize = byteSize;
            this.converter = converter;
        }
        public static final DataType INT = new DataType(4,new Converter(){
            @Override
            public Integer convert(byte[] data){
                return ByteBuffer.wrap(data).getInt();
            }
        });
        interface Converter{
            <T> T convert(byte[] data);
        }
    }
    
    DataFormat() {
    }
    static DataFormatBuilder builder() {
        return new DataFormatBuilder();
    }
    static class DataFormatBuilder{
        List<GameObject> gameObjects = new ArrayList<GameObject>();
        private DataFormatBuilder() {
        }
        DataFormat build() {
            return new DataFormat();
        }
    }
    
    
}


