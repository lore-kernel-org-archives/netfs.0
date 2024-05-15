Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF6EA5D477
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 08:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715763400; cv=none; b=VfhjhLBaD2SlDsyT68DDc+nGc2oPQRnHOYpLwWdQZmaA81ur9AuziPyys/bueKVSU03FaIFcekGjfItFhjnFZqRp/Dw6cz6mDIMraP7w7t+uLkY2otO0IXXc2IbvQnC0Y2NIV1RvCNhjFBCiGu9ou9+fa9LdeY+Vl+0ijGtlkk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715763400; c=relaxed/simple;
	bh=Uc4tFnEVf0RBkrgW0ECtX/HMO8s5cgdWU4r75pK1QsY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VOWfiBbErMFF+erS2VEwNpH4JTVZ872bnrebJSRa5KUgrc+J/zAF/jFzryeVJVnBn1wZU51IfN4GYopwPJzWULhe1+aziThkILj5ZPx46F28McnFNdVSID5EqdYosh8Lh9BirWQvkQzfXOIk56javcfQw9phNyejki7Z7bAUV9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTP id 4VfRsd3CK2z4f3jJH
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 16:56:21 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 1E31A1A0181
	for <netfs@lists.linux.dev>; Wed, 15 May 2024 16:56:30 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.67])
	by APP1 (Coremail) with SMTP id cCh0CgDHlxC7eERm68LgMg--.42328S4;
	Wed, 15 May 2024 16:56:29 +0800 (CST)
From: libaokun@huaweicloud.com
To: netfs@lists.linux.dev,
	dhowells@redhat.com,
	jlayton@kernel.org
Cc: hsiangkao@linux.alibaba.com,
	jefflexu@linux.alibaba.com,
	zhujia.zj@bytedance.com,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	libaokun@huaweicloud.com,
	yangerkun@huawei.com,
	houtao1@huawei.com,
	yukuai3@huawei.com,
	wozizhi@huawei.com,
	Baokun Li <libaokun1@huawei.com>
Subject: [PATCH v2 00/12] cachefiles: some bugfixes and cleanups for ondemand requests
Date: Wed, 15 May 2024 16:45:49 +0800
Message-Id: <20240515084601.3240503-1-libaokun@huaweicloud.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netfs@lists.linux.dev
List-Id: <netfs.lists.linux.dev>
List-Subscribe: <mailto:netfs+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:netfs+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:cCh0CgDHlxC7eERm68LgMg--.42328S4
X-Coremail-Antispam: 1UD129KBjvJXoWxXr1fur4rCw1xGF4xWw1kAFb_yoW5GrWrpF
	WSk3Wakry8Wr40k3s7Ar4rJryrA3yfAF9Fgw12g34DAwn8Xr15ZrWxtr15XFy5CrZxJw42
	q3WUuF97J34qv3DanT9S1TB71UUUUUUqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWUuVWrJwAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lFIxGxcIEc7CjxVA2
	Y2ka0xkIwI1lw4CEc2x0rVAKj4xxMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r
	1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CE
	b7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0x
	vE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw20EY4v20xvaj40_WFyUJVCq3wCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjfUYWrWUUUUU
X-CM-SenderInfo: 5olet0hnxqqx5xdzvxpfor3voofrz/

From: Baokun Li <libaokun1@huawei.com>

Hi all!

This is the second version of this patch series. Thank you, Jia Zhu and
Jingbo Xu, for the feedback in the previous version.

We've been testing ondemand mode for cachefiles since January, and we're
almost done. We hit a lot of issues during the testing period, and this
patch set fixes some of the issues related to ondemand requests.
The patches have passed internal testing without regression.

The following is a brief overview of the patches, see the patches for
more details.

Patch 1-5: Holding reference counts of reqs and objects on read requests
to avoid malicious restore leading to use-after-free.

Patch 6-10: Add some consistency checks to copen/cread/get_fd to avoid
malicious copen/cread/close fd injections causing use-after-free or hung.

Patch 11: When cache is marked as CACHEFILES_DEAD, flush all requests,
otherwise the kernel may be hung. since this state is irreversible, the
daemon can read open requests but cannot copen.

Patch 12: Allow interrupting a read request being processed by killing
the read process as a way of avoiding hung in some special cases.

Comments and questions are, as always, welcome.
Please let me know what you think.

Thanks,
Baokun

Changes since v1:
  * Collect RVB from Jia Zhu and Jingbo Xu.(Thanks for your review!)
  * Pathch 1: Add Fixes tag and enrich the commit message.
  * Pathch 7: Add function graph comments.
  * Pathch 8: Update commit message and comments.
  * Pathch 9: Enriched commit msg.

Baokun Li (11):
  cachefiles: remove request from xarry during flush requests
  cachefiles: remove err_put_fd tag in cachefiles_ondemand_daemon_read()
  cachefiles: fix slab-use-after-free in cachefiles_ondemand_get_fd()
  cachefiles: fix slab-use-after-free in
    cachefiles_ondemand_daemon_read()
  cachefiles: add output string to cachefiles_obj_[get|put]_ondemand_fd
  cachefiles: add consistency check for copen/cread
  cachefiles: add spin_lock for cachefiles_ondemand_info
  cachefiles: never get a new anonymous fd if ondemand_id is valid
  cachefiles: defer exposing anon_fd until after copy_to_user() succeeds
  cachefiles: flush all requests after setting CACHEFILES_DEAD
  cachefiles: make on-demand read killable

Zizhi Wo (1):
  cachefiles: Set object to close if ondemand_id < 0 in copen

 fs/cachefiles/daemon.c            |   3 +-
 fs/cachefiles/internal.h          |   5 +
 fs/cachefiles/ondemand.c          | 218 ++++++++++++++++++++++--------
 include/trace/events/cachefiles.h |   8 +-
 4 files changed, 177 insertions(+), 57 deletions(-)

-- 
2.39.2

