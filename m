Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE79B1F4FBA
	for <netfs@lists.linux.dev>; Thu,  7 Nov 2024 11:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730977832; cv=none; b=CqIn6RJxXvZvFSUR3YqTGdx5xt9+Xo0dh4RX825UmftdHUazNg+BWqe1yzfJGIfTBxaRLIIZYvHTuZVMccR86aU5UOVYL0zcToAV7F4RxOCkPBtmiHL3iwGrv1fGAO8RLcYZPrWUphoS8iQeUyDclmJTWu1+rGb1XOeUKn/WNbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730977832; c=relaxed/simple;
	bh=RVVmHJ2hHNmXUopsdCaH/m3BSyOH2T6JXPZrJTIBz7I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XWhImPBrEstsQhzXod4FVL7/5fvtx2igRkEUmq8Bb5DYbRaGmT6ferU4SZSJFX+G6iuWB9FMkF+zlyuGzjlKa73q3LvkLy4fawW74deepYnTD1WHDIaxlzTWfA7QMNxgttlG2vI33Qt8bpd2OkgbO0lE3KTqmO+SFpESm0VC9Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4XkfT31B71z2Fbqn;
	Thu,  7 Nov 2024 19:08:39 +0800 (CST)
Received: from kwepemf100017.china.huawei.com (unknown [7.202.181.16])
	by mail.maildlp.com (Postfix) with ESMTPS id 8379B1401E9;
	Thu,  7 Nov 2024 19:10:21 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemf100017.china.huawei.com
 (7.202.181.16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Thu, 7 Nov
 2024 19:10:20 +0800
From: Zizhi Wo <wozizhi@huawei.com>
To: <netfs@lists.linux.dev>, <dhowells@redhat.com>, <jlayton@kernel.org>,
	<brauner@kernel.org>
CC: <hsiangkao@linux.alibaba.com>, <jefflexu@linux.alibaba.com>,
	<zhujia.zj@bytedance.com>, <linux-erofs@lists.ozlabs.org>,
	<linux-fsdevel@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<wozizhi@huawei.com>, <libaokun1@huawei.com>, <yangerkun@huawei.com>,
	<houtao1@huawei.com>, <yukuai3@huawei.com>
Subject: [PATCH v2 0/5] fscache/cachefiles: Some bugfixes
Date: Thu, 7 Nov 2024 19:06:44 +0800
Message-ID: <20241107110649.3980193-1-wozizhi@huawei.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemf100017.china.huawei.com (7.202.181.16)

Changes since V1[1]:
 - Removed some incorrect patches.
 - Modified the description of the first patch.
 - Modified the fourth patch to move fput out of lock execution.

Recently, I sent the first version of the patch series. After some
discussions, I made modifications to a few patches and have now officially
sent this second version.

This patchset mainly includes 5 fix patches about fscache/cachefiles.
Additionally, patches 2, 3, and 5 have already been ACKed. The first patch
fixes an issue with the incorrect return length, and the fourth patch
addresses a null pointer dereference issue with file.

[1] https://lore.kernel.org/all/20240821024301.1058918-1-wozizhi@huawei.com/

Zizhi Wo (5):
  cachefiles: Fix incorrect length return value in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Fix missing pos updates in
    cachefiles_ondemand_fd_write_iter()
  cachefiles: Clean up in cachefiles_commit_tmpfile()
  cachefiles: Fix NULL pointer dereference in object->file
  netfs/fscache: Add a memory barrier for FSCACHE_VOLUME_CREATING

 fs/cachefiles/interface.c | 14 ++++++++++----
 fs/cachefiles/namei.c     |  5 -----
 fs/cachefiles/ondemand.c  | 38 +++++++++++++++++++++++++++++---------
 fs/netfs/fscache_volume.c |  3 +--
 4 files changed, 40 insertions(+), 20 deletions(-)

-- 
2.39.2

