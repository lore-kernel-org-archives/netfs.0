Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F151615444F
	for <netfs@lists.linux.dev>; Wed, 21 Aug 2024 02:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724208466; cv=none; b=kKGAL+49yL/fSHFm7kjt1M7H/5moknPTbSpW37As+XX1Oj+aW6KCfKsQiLMIOWtfrcOFh8+xNUloPJ3sqK6dpJcyi4V/2VBKcCYswYldBkZYGmVDbyeDlynz+EPKFU6pssE8auY/1Bn2JM12jI40o+8+2i4UdR9ibpiIF/KO1KU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724208466; c=relaxed/simple;
	bh=vbWZpFlB+VGH8XbbF+2TVJKrwCxauNm2e6n7CY6AVvo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Jq4Swqe4jqDv7euFbe36g7eySxOLvVfyRaVXiiy2jqPWSHt2fg8L4ZqHKREiQjOK99C/jSmBXcbSP78ehl5a1ltzjBfl0UEzHycT+uyLDk5htD4uC4wUZm8sXIn6PEUAq0jTJ5O0nD2ZpWPDLBtEqU3cgSWhlXUrSWJU8Sjc5Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WpW1D2ZmjzpSwr;
	Wed, 21 Aug 2024 10:46:08 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 3982A1800A7;
	Wed, 21 Aug 2024 10:47:39 +0800 (CST)
Received: from localhost.localdomain (10.175.104.67) by
 kwepemf100017.china.huawei.com (7.202.181.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 10:47:37 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH 0/8] netfs/cachefiles: Some bugfixes
Date: Wed, 21 Aug 2024 10:42:53 +0800
Message-ID: <20240821024301.1058918-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Hi!

We recently discovered some bugs through self-discovery and testing in
erofs ondemand loading mode, and this patchset is mainly used to fix
them. These patches are relatively simple changes, and I would be excited
to discuss them together with everyone. Below is a brief introduction to
each patch:

Patch 1: Fix for wrong block_number calculated in ondemand write.

Patch 2: Fix for wrong length return value in ondemand write.

Patch 3: Fix missing position update in ondemand write, for scenarios
involving read-ahead, invoking the write syscall.

Patch 4: Previously, the last redundant data was cleared during the umount
phase. This patch remove unnecessary data in advance.

Patch 5: Code clean up for cachefiles_commit_tmpfile().

Patch 6: Modify error return value in cachefiles_daemon_secctx().

Patch 7: Fix object->file Null-pointer-dereference problem.

Patch 8: Fix for memory out of order in fscache_create_volume().


Zizhi Wo (8):
  cachefiles: Fix incorrect block calculations in
    __cachefiles_prepare_write()
  cachefiles: Fix incorrect length return value in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Fix missing pos updates in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Clear invalid cache data in advance
  cachefiles: Clean up in cachefiles_commit_tmpfile()
  cachefiles: Modify inappropriate error return value in
    cachefiles_daemon_secctx()
  cachefiles: Fix NULL pointer dereference in object->file
  netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

 fs/cachefiles/daemon.c    |  2 +-
 fs/cachefiles/interface.c |  3 +++
 fs/cachefiles/io.c        | 10 +++++-----
 fs/cachefiles/namei.c     | 23 +++++++++++++----------
 fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
 fs/netfs/fscache_volume.c |  3 +--
 6 files changed, 52 insertions(+), 27 deletions(-)

-- 
2.39.2

