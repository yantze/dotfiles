#!/bin/bash

# Windows RDP 实例管理脚本

# 环境变量配置（可通过环境变量覆盖）
: ${RDP_IMAGE_ID:=ImageId}
: ${RDP_PASSWORD:=Password}
: ${RDP_SECURITY_GROUP_ID:=SecurityGroupId}
: ${RDP_VSWITCH_ID:=VSwitchId}

# 创建并启动一台 windows 电脑：型号 t5-c1m2.xlarge 价格 0.16 cny/h
create_windows() {
  echo "正在启动实例..."

  # 全新镜像 win2025_24H2_x64_dtc_zh-cn_40G_uefi_alibase_20250113.vhd
  response=$(aliyun ecs RunInstances --region cn-hangzhou --InstanceChargeType PostPaid --RegionId 'cn-hangzhou' --ZoneId 'cn-hangzhou-h' \
    --InstanceType 'ecs.t5-c1m2.xlarge' --IoOptimized optimized --SpotStrategy SpotAsPriceGo --SpotInterruptionBehavior Stop \
    --ImageId "$RDP_IMAGE_ID" --SecurityEnhancementStrategy Deactive --SystemDisk.Size 40 --SystemDisk.Category cloud_efficiency \
    --InternetChargeType PayByTraffic --InternetMaxBandwidthOut 50 --VSwitchId "$RDP_VSWITCH_ID" --SecurityGroupId "$RDP_SECURITY_GROUP_ID" --ImageOptions.LoginAsNonRoot false --InstanceName 'launch-advisor-20250217' \
    --PrivateDnsNameOptions.HostnameType Custom --UniqueSuffix false --HttpTokens optional --Tenancy default --Affinity default --Amount 1 --Password "$RDP_PASSWORD" --method POST --force)

  echo "$response"

  # 解析 JSON 响应，获取 InstanceIdSet 数组中的第一个实例 ID
  ecs_instance_id=$(echo "$response" | jq -r '.InstanceIdSets.InstanceIdSet[0]')

  echo "提取的实例 ID: $ecs_instance_id"

  echo $ecs_instance_id > $HOME/windows_instance.txt

  # 获取实例信息
  sleep 5
  public_ip=$(aliyun ecs DescribeInstanceAttribute --region cn-hangzhou --InstanceId "$ecs_instance_id" | jq -r '.PublicIpAddress.IpAddress[0]')

  echo "提取的公网IP: $public_ip"

  # 更新域名记录
  echo "正在更新域名记录..."
  # 生成的单条域名解析内容 1979452225806966784
  aliyun alidns UpdateDomainRecord --region public --Lang zh --RecordId 1979452225806966784 --RR win --Type A --Value "$public_ip" --TTL 600 --Priority 1 --Line default

  echo 当前时间 $(date "+%Y-%m-%d %H:%M")
  echo 等待 2 min 后建立链接
  sleep 140
  echo 可以建立链接
}

# 销毁实例
delete_windows() {
  ecs_instance_id=$(head -n 1 $HOME/windows_instance.txt)
  echo 销毁 $ecs_instance_id 实例中...
  aliyun ecs DeleteInstance --region cn-hangzhou --Force true --InstanceId "$ecs_instance_id"
  echo "" > $HOME/windows_instance.txt
}

# 启动实例
start_windows() {
  ecs_instance_id=$(head -n 1 $HOME/windows_instance.txt)
  echo 启动 $ecs_instance_id 实例中...
  aliyun ecs StartInstance --region cn-hangzhou --InstanceId "$ecs_instance_id"
  # https://help.aliyun.com/zh/ecs/developer-reference/api-ecs-2014-05-26-startinstance?spm=a2c4g.11186623.help-menu-25365.d_1_1_4_2_2.2a1c37efPYlEW0&scm=20140722.H_2679679._.OR_help-T_cn~zh-V_1
}

# 停止实例
stop_windows() {
  ecs_instance_id=$(head -n 1 $HOME/windows_instance.txt)
  echo 停机 $ecs_instance_id 实例中...
  aliyun ecs StopInstance --region cn-hangzhou --InstanceId "$ecs_instance_id" \
    --StoppedMode StopCharging
  # https://help.aliyun.com/zh/ecs/developer-reference/api-ecs-2014-05-26-stopinstance?spm=a2c4g.11186623.help-menu-25365.d_1_1_4_2_4.7689f4a5GSyidV
}

# 主函数：根据命令行参数调用相应的函数
main() {
  case "$1" in
    create)
      create_windows
      ;;
    delete)
      delete_windows
      ;;
    start)
      start_windows
      ;;
    stop)
      stop_windows
      ;;
    *)
      echo "用法: $0 {create|delete|start|stop}"
      echo "  create  - 创建并启动 Windows 实例"
      echo "  delete  - 销毁 Windows 实例"
      echo "  start   - 启动 Windows 实例"
      echo "  stop    - 停止 Windows 实例"
      exit 1
      ;;
  esac
}

# 如果直接执行脚本（而非被 source），则调用主函数
if [[ "${BASH_SOURCE[0]}" == "${0}" ]]; then
  main "$@"
fi
